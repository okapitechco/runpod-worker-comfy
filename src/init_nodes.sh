NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    ## TILE UPSCALER
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    ## LAMA OBJECT REMOVAL
    "https://github.com/sipherxyz/comfyui-art-venture"
    ## REMBG (Image background remover)
    "https://github.com/berkelmas/rembg-comfyui-node"
    ## IP Adapter Plus Custom Node
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    ## TILE UPSCALER
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    ## BASE64 Image loader
    "https://github.com/Acly/comfyui-tooling-nodes"
    ## MIXLAB
    "https://github.com/shadowcz007/comfyui-mixlab-nodes"
    ## WAS NODE ???
    "https://github.com/WASasquatch/was-node-suite-comfyui"
    ## CONTROLNET
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    ## IMPACT PACK
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
    ## Advanced Controlnet
    "https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet"
    ## Easy Comfy Nodes for fetching from URL
    "https://github.com/wmatson/easy-comfy-nodes"
    ## Comfy Essentials
    "https://github.com/cubiq/ComfyUI_essentials"
)

function build_extra_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="/comfyui/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                    pip3 install -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip3 install -r "$requirements"
            fi
        fi
    done
}