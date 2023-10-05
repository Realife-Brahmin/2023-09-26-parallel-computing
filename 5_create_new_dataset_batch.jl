using JuliaHub # Load the package that provides an API to access JuliaHub datasets

# Generate some data - set `ENV["NUM_SINUSOIDS"]` higher for larger data
include("1_csv_gen.jl")

# Specify the new dataset's owner and name
dataset_user = get(ENV, "DATASET_USER", "jacob_vaverka2")
dataset_name = get(ENV, "DATASET_NAME", "parallel_computing_sinusoids")

@info("Uploading DataSet: $(DATASET_USER)/$(DATASET_NAME)")
JuliaHub.upload_dataset(
    JuliaHub.dataset((DATASET_USER, DATASET_NAME)),
    output_dir;
    create=true
)
