#!/bin/bash
#Base Image as L4T for jetpack 5.0.2
ARG BASE_IMAGE=nimbushaystack/haystack_noetic_person_follower_base:v2.1

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
RUN git config --global user.name "divagarn"

RUN git clone https://$user_id:${token_id}@github.com/haystack-nimbus/src.git -b noetic-main
RUN cd /haystack_ws/src && git tag -a $tag_ver -m "$tag_ver" && git push --tags

RUN cd /haystack_ws/src/haystack/src && git clone https://$user_id:${token_id}@github.com/mobiMaheshRamasamy/personFollower.git
RUN cd /haystack_ws/src/haystack/src/personFollower && git tag -a $tag_ver -m "$tag_ver" && git push --tags
RUN cd /haystack_ws/src/haystack/src && mv personFollower/* .

RUN ["/bin/bash", "-c", "source /opt/ros/noetic/setup.bash && cd /haystack_ws && catkin_make -j4"]

WORKDIR /haystack_ws/src/haystack/ui
