from wolf import Task

class aggregate_tokens(Task):
    name = "aggregate_tokens"
    inputs = { "token_list", "pon_name" }
    script = """
# because MATLAB is braindead and can't resolve symlinks
while read -r token; do readlink -f $token; done < ${token_list} > token_list_symlinks.txt
/app/aggregate_tokens_files token_list_symlinks.txt ${pon_name}.bin
"""
    output_patterns = { "pon_binary" : "*.bin" }
    docker = "gcr.io/broad-getzlab-workflows/aggregate_pon_tokens:v7"
