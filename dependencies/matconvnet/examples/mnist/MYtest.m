function [ output_args ] = MYtest3( input_args )
%����д����mnistѵ����ѵ��������ģ�ͽ��в���,60000��ѵ����10000�����ԡ�28*28*1


% ����ȫ������
load('E:\matlabCode\matconvnet-1.0-beta23\matconvnet-1.0-beta23\data\mnist-baseline-simplenn\imdb.mat');
% ��ѡ������������ȫ�������ж�Ӧ�ı��60001-70000
test_index = find(images.set==3);%1��Ӧѵ������3��Ӧ���Լ���1�У�1����60000��3�У�60001����70000��
% ��ѡ�����Լ��Լ���ʵ���
test_data = images.data(:,:,:,test_index);
test_label = images.labels(test_index);
%����ѵ���õ�ģ�ͣ���20����Ч����ã�����ѡ��˷�������
load('E:\matlabCode\matconvnet-1.0-beta23\matconvnet-1.0-beta23\data\mnist-baseline-simplenn\net-epoch-20.mat');

% �����һ���Ϊ softmax ��ԭʼΪsoftmaxloss������ѵ���ã�
net.layers{1, end}.type = 'softmax';
% ��ÿ�Ų���ͼƬ���з���
for i = 1:length(test_label)
    i
    im_ = test_data(:,:,:,i);
    im_ = im_ - images.data_mean;
    res = vl_simplenn(net, im_) ;
    scores = squeeze(gather(res(end).x)) ;
    [bestScore, best] = max(scores) ;
    pre(i) = best;
   
end

% ����׼ȷ��
disp(test_label);
disp(pre);
accurcy = length(find(pre==test_label))/length(test_label);
disp(['accurcy = ',num2str(accurcy*100),'%']);

  
end

