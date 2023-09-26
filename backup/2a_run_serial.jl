using JuliaHub, DataSets, JSON3

data_dir = tempname()
dataset_user = "jacob_vaverka2"
dataset_name = "parallel_computing_sinusoids"
plot_dir = tempname()
ENV["RESULTS_FILE"] = plot_dir

!ispath(data_dir) && mkpath(data_dir)
!ispath(plot_dir) && mkpath(plot_dir)

# Load common code
include("common.jl")

# Get list of .CSV's we need to mash up
csv_dir = tempname()
JuliaHub.download_dataset(JuliaHub.dataset(dataset_name), csv_dir; version=4, replace=true)

# Do one processing round to precompile before we start timing
process_data(load_csv(first(csv_files)))

t_processing = @elapsed begin
    for f in csv_files
        @info("Processing $(basename(f))")
        # Load CSV into memory
        df = load_csv(f)

        # Process data
        m, m̂, best_pair = process_data(df)

        # Compare output with a `plot()`; save that to a file
        plot_data(f, df, m, m̂, best_pair)
    end
end
@info("Finished processing $(length(csv_files)) in $(t_processing) seconds ($(t_processing/length(csv_files)) per file)")
results = Dict(:num_files => length(csv_files), :time_per_file => t_generating/length(csv_files))
ENV["RESULTS"] = JSON3.pretty(results)
