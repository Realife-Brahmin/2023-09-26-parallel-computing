# Guide to Parallel Computing with Julia on JuliaHub

Start with a basic data science workflow and demonstrate benefits of parallel
programming using the Julia Programming Language.

## Timings

The timings recorded below are from a one test case. Your mileage will almost
certainly vary, but the general trend should remain true.

- Small
    - serial: ~2 seconds
    - threaded loop: ~0.66 seconds
    - threaded workers: ~0.56 seconds
- Large
    - serial: 734 seconds (24s per file)
    - threaded loop: 290 seconds (9.7s per file)
    - threaded workers: 172 seconds (5.8 per file)

> **NOTE**
> In the recorded webinar, there was a discrepancy between the live timings and
> the ones shown here. This was due to running the examples interactively
> rather than from the command line. Please follow the steps below to reproduce
> the correct timings.

## How to Run

Download the source code locally or to a JuliaHub IDE.

```shell
git clone https://github.com/jvaverka/2023-09-26-parallel-computing.git
```

Naviate into the directory and start Julia and activate the project environment.

```shell
cd 2023-09-26-parallel-computing
julia --project
```

Instantiate the environment (this may take a few minutes but only needs to be
done once). Once complete, you may exit Julia.

```julia
using Pkg
Pkg.instantiate()
exit()
```

Next, generate the data and save to CSV files in the scratch directory (again,
this is only necessary once).

```shell
julia --project 1_csv_gen.jl
```

Now, each of the 3 examples can be run.

```shell
julia --project 2_run_serial.jl
julia --project --threads=auto 3_run_threaded_loop.jl
julia --project --threads=auto 4_run_threaded_workers.jl
```

> **NOTE**
> It is a good exercise to run a resource monitor (such as `top` or `htop`)
> along side these examples. This can help to get a better understanding of CPU
> and memory usage while the programs are running.
