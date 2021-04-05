from wolf import Task

class aggregate_tokens(Task):
    name = "aggregate_tokens"
    inputs = { "token_list", "pon_name" }
    script = "/app/aggregate_tokens_files ${token_list} ${pon_name}.bin"
    output_patterns = { "pon_binary" : "*.bin" }
    docker = "gcr.io/broad-getzlab-workflows/aggregate_pon_tokens:v7"
