//
// Created by yjxiong on 11/18/15.
//

#ifndef DENSEFLOW_DENSE_FLOW_H
#define DENSEFLOW_DENSE_FLOW_H

#include "common.h"

void calcDenseFlow(std::string file_name, int bound, int type, int step,
                   std::vector<std::vector<uchar> >& output_x,
                   std::vector<std::vector<uchar> >& output_y,
                   std::vector<std::vector<uchar> >& output_img);
void calcDenseFlowGPU(std::string file_name, int bound, int type, int step, int dev_id,
                      std::vector<std::vector<uchar> >& output_x,
                      std::vector<std::vector<uchar> >& output_y,
                      std::vector<std::vector<uchar> >& output_img);

void calcDenseFlowPureGPU(std::string file_name, int bound, int type, int step, int dev_id,
                      std::vector<std::vector<uchar> >& output_x,
                      std::vector<std::vector<uchar> >& output_y,
                      std::vector<std::vector<uchar> >& output_img);

#endif //DENSEFLOW_DENSE_FLOW_H
