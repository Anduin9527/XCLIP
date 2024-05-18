#!/bin/bash

# Define the base command
base_command="python -m torch.distributed.launch --nproc_per_node=1 main.py"

# Define the common arguments
accum_steps=4

# Define the configurations and outputs based on powers of 2
configs=("configs/rader6/16_32_1.yaml" "configs/rader6/16_32_2.yaml" "configs/rader6/16_32_4.yaml" "configs/rader6/16_32_8.yaml")
outputs=("/hy-tmp/output/rader6_1" "/hy-tmp/output/rader6_2" "/hy-tmp/output/rader6_4" "/hy-tmp/output/rader6_8")

# Loop through the configs and outputs
for i in ${!configs[@]}; do
    config=${configs[$i]}
    output=${outputs[$i]}

    echo "Running command with $config and output $output..."
    $base_command -cfg $config --output $output --accumulation-steps $accum_steps
    if [ $? -ne 0 ]; then
        echo "Command with $config and output $output failed."
        exit 1
    fi
done

echo "All commands executed successfully."
