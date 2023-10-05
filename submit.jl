using JuliaHub, Dates

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "5_create_new_dataset_batch.jl"),
    ncpu=8, memory=8, nnodes=1,
    alias="Parallel Computing - batch dataset upload",
    env=Dict(
        "NUM_SINUSOIDS" => "200",
        "DATASET_USER" => "jacob_vaverka2",
        "DATASET_NAME" => "small_batch_sinusoids"
    ),
    timelimit=Hour(2)
)

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "6_run_serial_batch.jl"),
    ncpu=8, memory=8, nnodes=1,
    alias="Parallel Computing - batch serial run",
    env=Dict(
        "DATASET_USER" => "jacob_vaverka2",
        "DATASET_NAME" => "small_batch_sinusoids"
    ),
    timelimit=Hour(2)
)

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "7_run_threaded_workers_batch.jl"),
    ncpu=8, memory=8, nnodes=1,
    alias="Parallel Computing - batch threaded workers run",
    env=Dict(
        "DATASET_USER" => "jacob_vaverka2",
        "DATASET_NAME" => "small_batch_sinusoids"
    ),
    timelimit=Hour(2)
)
