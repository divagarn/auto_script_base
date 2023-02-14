#!/bin/bash
#Base Image as L4T for jetpack 5.0.2
ARG BASE_IMAGE=nimbushaystack/haystack_noetic_image_base:v1.0

FROM ${BASE_IMAGE}
ENV DEBIAN_FRONTEND=noninteractive

RUN cd /haystack_ws
RUN rm -rf src

RUN git clone https://<userid>:<tokenid>@github.com/haystack-nimbus/src.git -b noetic-main
RUN git tag <tage_name>
RUN ["/bin/bash", "-c", "source /opt/ros/noetic/setup.bash && cd /haystack_ws && catkin_make -j4"]



WORKDIR /haystack_ws/src/haystack/ui
