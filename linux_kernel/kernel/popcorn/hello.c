/*
 * @file init.c
 *
 * Copyright (c) 2013 - 2014, Akshay
 * modified by Antonio Barbalace, 2014
 * rewritten by Sang-Hoon Kim, 2016-2017
 * rewritten by Xincheng Yang, 2026-
 */

#include <linux/kernel.h>
#include <linux/init.h>

static int __init popcorn_init(void)
{
    pr_info("Popcorn: Hello World!\n");
    return 0;
}

late_initcall(popcorn_init);
