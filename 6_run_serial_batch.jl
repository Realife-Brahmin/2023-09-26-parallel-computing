using JuliaHub # Load API for accessing datasets on JuliaHub
using JSON3 # Load package to write job RESULTS

# Sipecify the username and dataset name
dataset_user = get(ENV, "DATASET_USER", "jacob_vaverka2")
dataset_name = get(ENV, "DATASET_NAME", "parallel_computing_sinusoids")

# Get list of .CSV's we need to mash up
csv_dir = tempname()
JuliaHub.download_dataset(JuliaHub.dataset((dataset_user, dataset_name)), csv_dir)

# Create the directory to save result files (in this case lots of image files)
plot_dir = tempname()
!ispath(plot_dir) && mkpath(plot_dir)
ENV["RESULTS_FILE"] = plot_dir

# Load common code
include("common.jl")

# Do one processing round to precompile before we start timing
process_data(load_csv(first(csv_files)))

# Process all files and obtain the time it took to complete the computational process
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

# Log a message describing the time needed per file
@info("Finished processing $(length(csv_files)) in $(t_processing) seconds ($(t_processing/length(csv_files)) per file)")

# Create a dictionary of process stats
results = Dict(
    :num_files => length(csv_files),
    :time_per_file => t_generating/length(csv_files)
)

# Save the stats - view them in the Job details
ENV["RESULTS"] = JSON3.pretty(results)
