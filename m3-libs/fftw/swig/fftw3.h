/*
 * Copyright (c) 2003 Matteo Frigo
 * Copyright (c) 2003 Massachusetts Institute of Technology
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

/* header file for fftw3 */
/* $Id$ */

#ifndef FFTW3_H
#define FFTW3_H

#include <stdio.h>

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

/* If <complex.h> is included, use the C99 complex type.  Otherwise
   define a type bit-compatible with C99 complex */
#ifdef _Complex_I
#  define FFTW_DEFINE_COMPLEX(R, C) typedef R _Complex C
#else
#  define FFTW_DEFINE_COMPLEX(R, C) typedef R C[2]
#endif

#define FFTW_CONCAT(prefix, name) prefix ## name
#define FFTW_MANGLE_DOUBLE(name) FFTW_CONCAT(fftw_, name)
#define FFTW_MANGLE_FLOAT(name) FFTW_CONCAT(fftwf_, name)
#define FFTW_MANGLE_LONG_DOUBLE(name) FFTW_CONCAT(fftwl_, name)

#define C1 complex_array_1d
#define C2 complex_array_2d
#define C3 complex_array_3d
#define Cn complex_tensor

#define R1 real_array_1d
#define R2 real_array_2d
#define R3 real_array_3d
#define Rn real_tensor


enum fftw_r2r_kind_do_not_use_me {
     FFTW_R2HC=0, FFTW_HC2R=1, FFTW_DHT=2,
     FFTW_REDFT00=3, FFTW_REDFT01=4, FFTW_REDFT10=5, FFTW_REDFT11=6,
     FFTW_RODFT00=7, FFTW_RODFT01=8, FFTW_RODFT10=9, FFTW_RODFT11=10
};

struct fftw_iodim_do_not_use_me {
     int n;                     /* dimension size */
     int is;			/* input stride */
     int os;			/* output stride */
};

/*
  huge second-order macro that defines prototypes for all API
  functions.  We expand this macro for each supported precision

  X: name-mangling macro
  R: real data type
  C: complex data type
*/

#define FFTW_DEFINE_API(X, R, C)					\
									\
FFTW_DEFINE_COMPLEX(R, C);						\
									\
typedef struct X(plan_s) *X(plan);					\
									\
typedef struct C X(C1);							\
typedef struct C X(C2);							\
typedef struct C X(C3);							\
typedef struct C X(Cn);							\
									\
typedef R X(R1);							\
typedef R X(R2);							\
typedef R X(R3);							\
typedef R X(Rn);							\
									\
typedef struct fftw_iodim_do_not_use_me X(iodim);			\
									\
typedef enum fftw_r2r_kind_do_not_use_me X(r2r_kind);			\
									\
void X(execute)(const X(plan) p);					\
									\
X(plan) X(plan_dft)(int rank, const int *n,				\
		    X(Cn) *in, X(Cn) *out, int sign, unsigned flags);	\
									\
X(plan) X(plan_dft_1d)(int n, X(C1) *in, X(C1) *out, int sign,		\
		       unsigned flags);					\
X(plan) X(plan_dft_2d)(int nx, int ny,					\
		       X(C2) *in, X(C2) *out, int sign, unsigned flags);\
X(plan) X(plan_dft_3d)(int nx, int ny, int nz,				\
		       X(C3) *in, X(C3) *out, int sign, unsigned flags);\
									\
X(plan) X(plan_many_dft)(int rank, const int *n,			\
                         int howmany,					\
                         X(Cn) *in, const int *inembed,			\
                         int istride, int idist,			\
                         X(Cn) *out, const int *onembed,		\
                         int ostride, int odist,			\
                         int sign, unsigned flags);			\
									\
X(plan) X(plan_guru_dft)(int rank, const X(iodim) *dims,		\
			 int howmany_rank,				\
			 const X(iodim) *howmany_dims,			\
			 X(Cn) *in, X(Cn) *out,				\
			 int sign, unsigned flags);			\
X(plan) X(plan_guru_split_dft)(int rank, const X(iodim) *dims,		\
			 int howmany_rank,				\
			 const X(iodim) *howmany_dims,			\
			 R *ri, R *ii, R *ro, R *io,			\
			 unsigned flags);				\
									\
void X(execute_dft)(const X(plan) p, X(Cn) *in, X(Cn) *out);		\
void X(execute_split_dft)(const X(plan) p,				\
			 X(n)R *ri, X(Rn) *ii, X(Rn) *ro, X(Rn) *io);	\
									\
X(plan) X(plan_many_dft_r2c)(int rank, const int *n,			\
                             int howmany,				\
                             X(Rn) *in, const int *inembed,		\
                             int istride, int idist,			\
                             X(Cn) *out, const int *onembed,		\
                             int ostride, int odist,			\
                             unsigned flags);				\
									\
X(plan) X(plan_dft_r2c)(int rank, const int *n,				\
                        X(Rn) *in, X(Cn) *out, unsigned flags);		\
									\
X(plan) X(plan_dft_r2c_1d)(int n,					\
			   X(R1) *in, X(C1) *out, unsigned flags);	\
X(plan) X(plan_dft_r2c_2d)(int nx, int ny,				\
			   X(R2) *in, X(C2) *out, unsigned flags);	\
X(plan) X(plan_dft_r2c_3d)(int nx, int ny, int nz,			\
			   X(R3) *in, X(C3) *out, unsigned flags);	\
									\
									\
X(plan) X(plan_many_dft_c2r)(int rank, const int *n,			\
			     int howmany,				\
			     X(Cn) *in, const int *inembed,		\
			     int istride, int idist,			\
			     X(Rn) *out, const int *onembed,		\
			     int ostride, int odist,			\
			     unsigned flags);				\
									\
X(plan) X(plan_dft_c2r)(int rank, const int *n,				\
                        X(Cn) *in, X(Rn) *out, unsigned flags);		\
									\
X(plan) X(plan_dft_c2r_1d)(int n,					\
			   X(C1) *in, X(R1) *out, unsigned flags);	\
X(plan) X(plan_dft_c2r_2d)(int nx, int ny,				\
			   X(C2) *in, X(R2) *out, unsigned flags);	\
X(plan) X(plan_dft_c2r_3d)(int nx, int ny, int nz,			\
			   X(C3) *in, X(R3) *out, unsigned flags);	\
									\
X(plan) X(plan_guru_dft_r2c)(int rank, const X(iodim) *dims,		\
			     int howmany_rank,				\
			     const X(iodim) *howmany_dims,		\
			     X(Rn) *in, X(Cn) *out,			\
			     unsigned flags);				\
X(plan) X(plan_guru_dft_c2r)(int rank, const X(iodim) *dims,		\
			     int howmany_rank,				\
			     const X(iodim) *howmany_dims,		\
			     X(Cn) *in, X(Rn) *out,			\
			     unsigned flags);				\
									\
X(plan) X(plan_guru_split_dft_r2c)(int rank, const X(iodim) *dims,	\
			     int howmany_rank,				\
			     const X(iodim) *howmany_dims,		\
			     X(Rn) *in, X(Rn) *ro, X(Rn) *io,		\
			     unsigned flags);				\
X(plan) X(plan_guru_split_dft_c2r)(int rank, const X(iodim) *dims,	\
			     int howmany_rank,				\
			     const X(iodim) *howmany_dims,		\
			     X(Rn) *ri, X(Rn) *ii, X(Rn) *out,		\
			     unsigned flags);				\
									\
void X(execute_dft_r2c)(const X(plan) p, X(Rn) *in, X(Cn) *out);	\
void X(execute_dft_c2r)(const X(plan) p, X(Cn) *in, X(Rn) *out);	\
									\
void X(execute_split_dft_r2c)(const X(plan) p,				\
			 X(Rn) *in, X(Rn) *ro, X(Rn) *io);		\
void X(execute_split_dft_c2r)(const X(plan) p,				\
			 X(Rn) *ri, X(Rn) *ii, X(Rn) *out);		\
									\
X(plan) X(plan_many_r2r)(int rank, const int *n,			\
                         int howmany,					\
                         X(Rn) *in, const int *inembed,			\
                         int istride, int idist,			\
                         X(Rn) *out, const int *onembed,		\
                         int ostride, int odist,			\
                         const X(r2r_kind) *kind, unsigned flags);	\
									\
X(plan) X(plan_r2r)(int rank, const int *n, X(Rn) *in, X(Rn) *out,	\
                    const X(r2r_kind) *kind, unsigned flags);		\
									\
X(plan) X(plan_r2r_1d)(int n, X(R1) *in, X(R1) *out,			\
                       X(r2r_kind) kind, unsigned flags);		\
X(plan) X(plan_r2r_2d)(int nx, int ny, X(R2) *in, X(R2) *out,		\
                       X(r2r_kind) kindx, X(r2r_kind) kindy,		\
                       unsigned flags);					\
X(plan) X(plan_r2r_3d)(int nx, int ny, int nz,				\
                       X(R3) *in, X(R3) *out, X(r2r_kind) kindx,	\
                       X(r2r_kind) kindy, X(r2r_kind) kindz,		\
                       unsigned flags);					\
									\
X(plan) X(plan_guru_r2r)(int rank, const X(iodim) *dims,		\
                         int howmany_rank,				\
                         const X(iodim) *howmany_dims,			\
                         X(Rn) *in, X(Rn) *out,				\
                         const X(r2r_kind) *kind, unsigned flags);	\
void X(execute_r2r)(const X(plan) p, X(Rn) *in, X(Rn) *out);		\
									\
void X(destroy_plan)(X(plan) p);					\
void X(forget_wisdom)(void);						\
void X(cleanup)(void);							\
									\
void X(plan_with_nthreads)(int nthreads);				\
int X(init_threads)(void);						\
void X(cleanup_threads)(void);						\
									\
void X(export_wisdom_to_file)(FILE *output_file);			\
char *X(export_wisdom_to_string)(void);					\
void X(export_wisdom)(void (*write_char)(char c, void *), void *data);	\
int X(import_system_wisdom)(void);					\
int X(import_wisdom_from_file)(FILE *input_file);			\
int X(import_wisdom_from_string)(const char *input_string);		\
int X(import_wisdom)(int (*read_char)(void *), void *data);		\
									\
void X(fprint_plan)(const X(plan) p, FILE *output_file);		\
void X(print_plan)(const X(plan) p);					\
									\
void *X(malloc)(size_t n);						\
void X(free)(void *p);							\
									\
void X(flops)(const X(plan) p, double *add, double *mul, double *fma);	\
									\
extern const char X(version)[];						\
extern const char X(cc)[];						\
extern const char X(codelet_optim)[];


/* end of FFTW_DEFINE_API macro */

FFTW_DEFINE_API(FFTW_MANGLE_DOUBLE, double, fftw_complex)
FFTW_DEFINE_API(FFTW_MANGLE_FLOAT, float, fftwf_complex)
FFTW_DEFINE_API(FFTW_MANGLE_LONG_DOUBLE, long double, fftwl_complex)

#define FFTW_FORWARD (-1)
#define FFTW_BACKWARD (+1)

/* documented flags */
#define FFTW_MEASURE (0U)
#define FFTW_DESTROY_INPUT (1U << 0)
#define FFTW_UNALIGNED (1U << 1)
#define FFTW_CONSERVE_MEMORY (1U << 2)
#define FFTW_EXHAUSTIVE (1U << 3) /* NO_EXHAUSTIVE is default */
#define FFTW_PRESERVE_INPUT (1U << 4) /* cancels FFTW_DESTROY_INPUT */
#define FFTW_PATIENT (1U << 5) /* IMPATIENT is default */
#define FFTW_ESTIMATE (1U << 6)

/* undocumented beyond-guru flags */
#define FFTW_ESTIMATE_PATIENT (1U << 7)
#define FFTW_BELIEVE_PCOST (1U << 8)
#define FFTW_DFT_R2HC_ICKY (1U << 9)
#define FFTW_NONTHREADED_ICKY (1U << 10)
#define FFTW_NO_BUFFERING (1U << 11)
#define FFTW_NO_INDIRECT_OP (1U << 12)
#define FFTW_ALLOW_LARGE_GENERIC (1U << 13) /* NO_LARGE_GENERIC is default */
#define FFTW_NO_RANK_SPLITS (1U << 14)
#define FFTW_NO_VRANK_SPLITS (1U << 15)
#define FFTW_NO_VRECURSE (1U << 16)

#define FFTW_NO_SIMD (1U << 17)

#ifdef __cplusplus
}  /* extern "C" */
#endif /* __cplusplus */

#endif /* FFTW3_H */
