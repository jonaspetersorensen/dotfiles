FROM nvcr.io/nvidia/k8s/cuda-sample:nbody
USER 1000
CMD ["nbody", "-benchmark"]