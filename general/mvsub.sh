#!/bin/bash

echo 'moving subfolder contents'
mv ./*/* ./
echo 'deleteing emopty dirs'
find -type d -empty -delete
echo 'process complete'
