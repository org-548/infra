#!/bin/bash

for i in $(ls ./values/); do
  yq eval .deploy.image.tag values/$i >> val-from-chart.out
done
