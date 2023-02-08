#!/bin/bash
#Base Image as L4T for jetpack 5.0.2
ARG BASE_IMAGE=nimbushaystack/haystack_noetic_person_follower_base:v0.0

FROM ${BASE_IMAGE}
ENV DEBIAN_FRONTEND=noninteractive

RUN cd /haystack_ws
RUN rm -rf src

RUN git clone https://<userid>:<tokenid>@github.com/haystack-nimbus/src.git -b noetic-main
RUN ["/bin/bash", "-c", "source /opt/ros/noetic/setup.bash && cd /haystack_ws && catkin_make"]



WORKDIR /haystack_ws/src/haystack/ui

