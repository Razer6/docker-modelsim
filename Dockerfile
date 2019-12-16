FROM ubuntu:16.04

LABEL maintainer Robert Schilling <robert.schilling@iaik.tugraz.at>

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 && \
    apt-get install -y lib32ncurses5 && \
    apt-get install -y libxft2 libxft2:i386 lib32ncurses5 && \
    apt-get install -y libxext6 && \
    apt-get install -y libxext6:i386 && \
    apt-get install -y wget

ARG DOWNLOAD_HOST
RUN wget ${DOWNLOAD_HOST}/ModelSimProSetup-18.1.0.222-linux.run -q  && \
    wget ${DOWNLOAD_HOST}/modelsim-part2-18.1.0.222-linux.qdz -q  && \
    mkdir /opt/modelsim && \
    chmod +x ModelSimProSetup-18.1.0.222-linux.run && \
    ./ModelSimProSetup-18.1.0.222-linux.run --accept_eula 1 --unattendedmodeui  minimal --mode unattended --installdir /opt/modelsim --modelsim_edition modelsim_ase

/opt/modelsim/modelsim_ase/bin

sed -i 's/mode=${MTI_VCO_MODE:-""}/mode=${MTI_VCO_MODE:-"32"}/g' /opt/modelsim/modelsim_ase/bin/vsim
sed -i 's/*)                vco="linux_rh60" ;;/*)                vco="linux" ;;/g' /opt/modelsim/modelsim_ase/bin/vsim