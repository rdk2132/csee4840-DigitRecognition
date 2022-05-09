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
#include <linux/delay.h>

#include "../software-testbench/Parameters.h"

#define DRIVER_NAME "cnn"
#define CONTROL_OUT_REG(x) (x)
#define CONTROL_IN_REG(x) ((x) + 2)
#define INPUT_REG(x) ((x) + 4)
#define OUTPUT_REG_BASE(x) ((x) + 6)

struct cnn_dev {
    struct resource res; // Registers
    void __iomem *virtbase; // Location of registers in memory
    cnn_arg_t data;
} dev;

static void send_image(fixed_t *image)
{
    int i;

    for (i = 0; i < IMAGE_SIZE; i++){
        iowrite16(image[i], INPUT_REG(dev.virtbase));
    }
}

static void control(fixed_t *image) {
  fixed_t control_in;
  fixed_t control_out;

  // Load Image
  control_in = 1;
  iowrite16(control_in, CONTROL_IN_REG(dev.virtbase));
  do {
    control_out = ioread16(CONTROL_OUT_REG(dev.virtbase));
  } while (control_out != control_in)

  send_image(image);

  control_in = 2;
  for (; control_in < 7; control_in++) {
    // Send signal to start next layer
    iowrite16(control_in, CONTROL_IN_REG(dev.virtbase));
    
    // Wait for done signal from hardware
    do {
      control_out = ioread16(CONTROL_OUT_REG(dev.virtbase));
    } while (control_out != control_in)
  }
}

static void read_output(fixed_t *vector)
{
    int i;

    for (i = 0; i < NUM_CLASSES; i++){
        vector[i] = ioread16(OUTPUT_REG_BASE(dev.virtbase) + (2 * i));
    }
}

static long cnn_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
{
    cnn_arg_t in_data;

    switch (cmd)
    {
    case CNN_CLASSIFY:
	// Copy image from user
        if (copy_from_user(&in_data, (cnn_arg_t *)arg, sizeof(cnn_arg_t)))
            return -EACCES;

        control(in_data.in_image);
        
	// Read output
	read_output(in_data.classification_vector);
        if (copy_to_user((cnn_arg_t *)arg, &in_data, sizeof(cnn_arg_t)))
            return -EACCES;
        break;
    
    default:
        return -EINVAL;
    }
    
    return 0;
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

    pr_info("Before Misc register");
    /* Register as misc device, also creates /dev/cnn/ */
    ret = misc_register(&cnn_misc_device);
    pr_info("Misc register");

    // Obtain address of the registers from device tree
    ret = of_address_to_resource(pdev->dev.of_node, 0, &dev.res);
    if(ret)
    {
        ret = -ENOENT;
        goto out_deregister;
    }
    pr_info("of address");

    if (request_mem_region(dev.res.start, resource_size(&dev.res), 
                        	DRIVER_NAME) == NULL) {
      ret = -EBUSY;
      goto out_deregister;
    }
    pr_info("request mem region");


    // Arrange access to registers
    dev.virtbase = of_iomap(pdev->dev.of_node, 0);
    if(dev.virtbase ==  NULL) {
        ret = -ENOMEM;
        goto out_release_mem_region;
    }
    pr_info("of iomap");
    
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
    {.compatible = "csee4840,cnn_driver-1.0"},
    {},
};
MODULE_DEVICE_TABLE(of, cnn_of_match);
#endif

static struct platform_driver cnn_driver = {
    .driver = {
        .name = DRIVER_NAME,
        .owner = THIS_MODULE,
        .of_match_table = of_match_ptr(cnn_of_match),
    },
    .remove = __exit_p(cnn_remove),
};

static int __init cnn_driver_init(void)
{
    pr_info(DRIVER_NAME ": init\n");
    return platform_driver_probe(&cnn_driver, cnn_probe);
}

static void __exit cnn_driver_exit(void)
{
    platform_driver_unregister(&cnn_driver);
    pr_info(DRIVER_NAME ": exit\n");
}

module_init(cnn_driver_init);
module_exit(cnn_driver_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Liam Bishop and Ryan Kennedy");
MODULE_DESCRIPTION("CNN driver for fpga");
