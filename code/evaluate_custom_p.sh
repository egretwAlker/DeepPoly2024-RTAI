#!/bin/bash
echo "net,data,gt,duration,evaluation"
for entry in \
	"conv_linear,img0_mnist_0.030107.txt,not verified"\
	"conv_linear,img6_mnist_0.052523.txt,verified"\
	"fc_linear,img0_mnist_0.004477.txt,not verified"\
	"fc_linear,img6_mnist_0.102748.txt,verified"\
	"fc6_d,img0_mnist_0.004768.txt,not verified"\
	"fc6_d,img4_mnist_0.037590.txt,verified"\
	"fc6_d,img10_mnist_0.056404.txt,verified"\
	"fc6_w,img0_mnist_0.002323.txt,not verified"\
	"fc6_w,img4_mnist_0.051968.txt,verified"\
	"fc6_w,img10_mnist_0.046423.txt,verified"\
	"fc_dw,img0_mnist_0.018995.txt,not verified"\
	"fc_dw,img4_mnist_0.019369.txt,verified"\
	"fc_dw,img10_mnist_0.048601.txt,verified"\
	"fc6_base,img0_mnist_0.036379.txt,not verified"\
	"fc6_base,img4_mnist_0.034540.txt,verified"\
	"fc6_base,img10_mnist_0.053394.txt,verified"\
	"fc_base,img0_mnist_0.018335.txt,not verified"\
	"fc_base,img4_mnist_0.049512.txt,verified"\
	"fc_base,img10_mnist_0.072961.txt,verified"\
	"conv6_base,img0_cifar10_0.000593.txt,not verified"\
	"conv6_base,img4_cifar10_0.001726.txt,verified"\
	"conv6_base,img10_cifar10_0.003959.txt,verified"\
	"fc6_dw,img0_mnist_0.012496.txt,not verified"\
	"fc6_dw,img4_mnist_0.035530.txt,verified"\
	"fc6_dw,img10_mnist_0.052760.txt,verified"\
	"fc_d,img0_mnist_0.022949.txt,not verified"\
	"fc_d,img4_mnist_0.045868.txt,verified"\
	"fc_d,img10_mnist_0.071258.txt,verified"\
	"fc_w,img0_mnist_0.063666.txt,not verified"\
	"fc_w,img4_mnist_0.057236.txt,verified"\
	"fc_w,img10_mnist_0.082230.txt,verified"\
	"conv_d,img0_mnist_0.093947.txt,not verified"\
	"conv_d,img4_mnist_0.073991.txt,verified"\
	"conv_d,img10_mnist_0.084488.txt,verified"\
	"conv_base,img0_mnist_0.064285.txt,not verified"\
	"conv_base,img4_mnist_0.038857.txt,verified"\
	"conv_base,img10_mnist_0.062742.txt,verified"\
	"skip6,img0_mnist_0.014042.txt,not verified"\
	"skip6,img4_mnist_0.075734.txt,verified"\
	"skip6,img10_mnist_0.090667.txt,verified"\
	"skip_large,img0_mnist_0.081176.txt,not verified"\
	"skip_large,img4_mnist_0.033906.txt,verified"\
	"skip_large,img10_mnist_0.045195.txt,verified"\
	"skip,img0_mnist_0.023631.txt,not verified"\
	"skip,img4_mnist_0.055097.txt,verified"\
	"skip,img10_mnist_0.100253.txt,verified"\
	"skip6_large,img0_mnist_0.063030.txt,not verified"\
	"skip6_large,img4_mnist_0.024756.txt,verified"\
	"skip6_large,img10_mnist_0.035134.txt,verified"
do
	IFS=',' read -r net spec gt <<< "$entry"
	output=$({ time (timeout 60s python code/verifier.py --net ${net} --spec preliminary_test_cases/${net}/${spec} || echo not verified); } 2>&1)
	is_verified=$(echo "$output" | head -n 1)
	duration=$(echo "$output" | grep real | awk '{print $2}')
	if [ "$is_verified" = "$gt" ]; then
		evaluation="true"
	else
		evaluation="false"
	fi
	echo ${net},${spec},${gt},${duration},${evaluation}
done