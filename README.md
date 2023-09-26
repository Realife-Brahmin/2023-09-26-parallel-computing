# Guide to Parallel Computing with Julia on JuliaHub

Start with a basic data science workflow and demonstrate benefits of parallel programming using the Julia Programming Language.

## Timings

- Small
    - serial: ~2 seconds
    - threaded loop: ~0.66 seconds
    - threaded workers: ~0.56 seconds
- Large
    - serial: 734 seconds (24s per file)
    - threaded loop: 290 seconds (9.7s per file)
    - threaded workers: 172 seconds (5.8 per file)