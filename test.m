
clc;
clear all;
vid = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n'];
groupmembership = [1,1,1,1,1,1,2,2,2,3,3,3,3,4]; %分组情况
loss = [0.05,0.12,0.12,0.12,0.15,0.40,0.17,0.18,0.35,0.15,0.16,0.20,0.50,0.28]; %每个的loss
vid(SPLD(loss, groupmembership, 0.05,0.2))