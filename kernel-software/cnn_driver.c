/*
 * Device driver for the CNN used for CSEE4840 project
 *
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/errno.h>
#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/platform_device.h>
#include <linux/miscdevice.h>
#include <linux/slab.h>
#include <linux/io.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/fs.h>
#include <linux/uaccess.h>

#include "software-testbench/Parameters.h"

#define DRIVER_NAME "cnn_fpga"
#define CONTROL_OUT_REG(x) (x)
#define CONTROL_IN_REG(x) ((x) + 2)
#define INPUT_REG(x) ((x) + 4)
#define OUTPUT_BASE_REG(x) ((x) + 6)
#define WRITE_READY(x) (x & 0x1000)

struct cnn_dev {
    struct resource res; // Registers
    void __iomem *virtbase; // Location of registers in memory
    cnn_arg_t data;
} dev;

static fixed_t *read_output(fixed_t *vector)
{
    //TODO: Check to ensure that the hardware has finished calculations
    // read the data from 
    int addr = OUTPUT_BASE_REG(dev.virtbase);

    for (int i = 0; i < NUM_CLASSES; i++)
    {
        vector[i] = ioread16((void *)addr);
        addr += 2;
    }
}

static void send_image(fixed_t *image)
{
    //TODO: Extract data from struct and send to fpga
    // after each send wait to read ack from fpga
    fixed_t

    for (int i = 0; i < IMAGE_SIZE; i++)
    {
        iowrite16(image[i], INPUT_REG(dev.virtbase));

        // WAIT FOR HANDSHAKE
        while (!WRITE_READY(ioread16(CONTROL_IN_REG(dev.virtbase))))
            ;
        
    }
    
}

static long cnn_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
{
    //TODO: One function uses CNN_CLASSIFY
    cnn_arg_t in_data;

    switch (cmd)
    {
    case CNN_CLASSIFY:
        if (copy_from_user(&in_data, (cnn_arg_t *)arg, sizeof(cnn_arg_t)))
            return -EACCES;
        send_image(in_data.in_image);

        // control stuff

        in_data.classification_vector = read_output();
        if (copy_to_user((cnn_arg_t *)arg, &in_data, sizeof(cnn_arg_t)))
            return -EACCES;
        break;
    
    default:
        break;
    }
    

}

static const struct file_operations cnn_fops = {
    .owner = THIS_MODULE,
    .unlocked_ioctl = cnn_ioctl,
};

static struct miscdevice cnn_misc_device = {
    .minor = MISC_DYNAMIC_MINOR,
    .name = DRIVER_NAME,
    .fops = &cnn_fops,
};

static int __init cnn_probe(struct platform_device *pdev)
{
    int ret;

    /* Register as misc device, also creates /dev/cnn/ */
    ret = misc_register(&cnn_misc_device);
    if(ret)
        goto out_deregister; 

    // Obtain address of the registers from device tree
    ret = of_address_to_resource(pdev->dev.of_node, 0, &dev.res);
    if(ret)
    {
        ret = -EBUSY;
        goto out_deregister;
    }

    // Arrange access to registers
    dev.virtbase = of_iomap(pdev->dev.of_node, 0);
    if(dev.virtbase ==  NULL)
    {
        ret = -ENOMEM;
        goto out_release_mem_region;
    }
    
    return 0;

out_release_mem_region:
    release_mem_region(dev.res.start, resource_size(&dev.res));
out_deregister:
    misc_deregister(&cnn_misc_device);
    return ret;
}

static int cnn_remove(struct platform_device *pdev)
{
    iounmap(dev.virtbase);
    release_mem_region(dev.res.start, resource_size(&dev.res));
    misc_deregister(&cnn_misc_device);
    return 0;
}

#ifdef CONFIG_OF
static const struct of_device_id cnn_of_match[] = {
    {.compatible = "csee4840,cnn-1.0"},
    {},
};
#endif

static struct platform_driver cnn_driver = {
    .driver = {
        .name = DRIVER_NAME,
        .owner = THIS_MODULE,
        .of_match_table = of_match_ptr(cnn_of_match),
    },
    .remove = __exit_p(cnn_remove),
};

static void __init cnn_driver_init(void)
{
    pr_info(DRIVER_NAME ": init\n");
}

static void __exit cnn_driver_exit(void)
{
    pr_info(DRIVER_NAME ": exit\n");
}

module_init(cnn_driver_init);
moodule_exit(cnn_driver_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Liam Bishop");
MODULE_DESCRIPTION("CNN driver for fpga");
