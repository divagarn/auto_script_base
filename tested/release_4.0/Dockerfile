#!/bin/bash
#Base Image as L4T for jetpack 5.0.2
ARG BASE_IMAGE=nimbushaystack/haystack_noetic_person_follower_base:v1.0

FROM ${BASE_IMAGE}
ENV DEBIAN_FRONTEND=noninteractive

RUN cd /haystack_ws
RUN rm -rf src
ARG token_id=${token_id}
ARG user_id=${user_id}
ARG tag_ver=${tag_ver}
ARG message=${tag_ver}
#RUN echo "Oh dang look at that ${token_id}"
RUN git config --global user.email "n.divagar@mobiveil.co.in"
RUN git config --global user.name "n.divagar"

RUN git clone https://$user_id:${token_id}@github.com/haystack-nimbus/src.git -b noetic-main
RUN cd /haystack_ws/src && git tag -a v0.0.2 -m "dev 0.1" && git push --tags

RUN cd /haystack_ws/src/haystack/src && git clone https://divagarn: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@github.com/mobiMaheshRamasamy/personFollower.git && mv personFollower/Person_Follower.py .

RUN ["/bin/bash", "-c", "source /opt/ros/noetic/setup.bash && cd /haystack_ws && catkin_make -j4"]



WORKDIR /haystack_ws/src/haystack/ui
