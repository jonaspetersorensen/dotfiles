FROM nvidia/cuda:11.6.2-base-ubuntu20.04
USER 1000
CMD ["nvidia-smi"]