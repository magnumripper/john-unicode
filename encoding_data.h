/*
 * This file is Copyright (c) 2009-2020 magnum and JimF,
 * and is hereby released to the general public under the following terms:
 * Redistribution and use in source and binary forms, with or without
 * modifications, are permitted.
 */

#ifndef __ENCODING_DATA_H__
#define __ENCODING_DATA_H__

/* for UTF16/UTF8 definition */
#include "unicode.h"

/*
 * unicode.c will declare the arrays as static and initialize them. All
 * others that source this file should declare them as external.
 */
#if JTR_UNICODE_C
#define EXTATIC static
#else
#define EXTATIC extern
#endif

/*
 * These are always invalid, but there are also a lot of multi-octet
 * combinations that are invalid but can't be matched this easily.
 */
#define CHARS_INVALID_UTF8 "\xc0\xc1\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff"

/* ----8<------8<---- AUTO-GENERATED DATA BELOW THIS POINT ----8<------8<---- */
