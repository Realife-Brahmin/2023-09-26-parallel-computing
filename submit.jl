using JuliaHub, Dates

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "1a_csv_gen.jl"),
    ncpu=4, memory=4, nnodes=1,
    alias="Parallel Computing - Single Process Data Generation",
    env=Dict("NUM_SINUSOIDS" => "2000"),
    timelimit=Hour(2)
)

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "1b_csv_gen.jl"),
    ncpu=4, memory=4, nnodes=11, process_per_node=true,
    alias="Parallel Computing - Distributed Process Data Generation",
    env=Dict("NUM_SINUSOIDS" => "2000"),
    timelimit=Hour(2)
)

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "2a_run_serial.jl"),
    ncpu=4, memory=4, nnodes=1,
    alias="Parallel Computing - Single Process Serial Run",
    timelimit=Hour(2)
)

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "4b_run_threaded_workers.jl"),
    ncpu=4, memory=4, nnodes=11, process_per_node=true,
    alias="Parallel Computing - Distributed Process Run",
    timelimit=Hour(2)
)
