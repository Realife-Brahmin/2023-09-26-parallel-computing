using JuliaHub, Dates

const NUM_SINUSOIDS = 200 # use `2000` for larger data
const CURRENT_USER = replace(JuliaHub.authenticate().username, "-" => "_")
const DATASET_NAME = "parallel_computing_sinusoids"

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "5_create_new_dataset_batch.jl"),
    ncpu=8, memory=8, nnodes=1,
    alias="Parallel Computing - batch dataset upload",
    env=Dict(
        "NUM_SINUSOIDS" => string(NUM_SINUSOIDS),
        "DATASET_USER" => CURRENT_USER,
        "DATASET_NAME" => DATASET_NAME
    ),
    timelimit=Hour(2)
)

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "6_run_serial_batch.jl"),
    ncpu=8, memory=8, nnodes=1,
    alias="Parallel Computing - batch serial run",
    env=Dict(
        "DATASET_USER" => CURRENT_USER,
        "DATASET_NAME" => DATASET_NAME
    ),
    timelimit=Hour(2)
)

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "7_run_threaded_workers_batch.jl"),
    ncpu=8, memory=8, nnodes=1,
    alias="Parallel Computing - batch threaded workers run",
    env=Dict(
        "DATASET_USER" => CURRENT_USER,
        "DATASET_NAME" => DATASET_NAME
    ),
    timelimit=Hour(2)
)
