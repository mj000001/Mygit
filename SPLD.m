function result = SPLD(loss, groupmembership, lambda, gamma)
%    SPLD 用于得到不同类别的训练样本
%
%	Parameters: loss     		- 每次训练得到的loss
%		    groupmembership     - 输入的loss对应分组
%		    lambda		- lambda控制自步学习样本选择
%		    gamma		- gamma控制自步学习多样性程度
%
    groupidx = unique(groupmembership); %获取一共多少组
    b = size(groupidx, 2); 
    selectedidx = zeros(size(loss));
    selectedsocres = zeros(size(loss));
    for j = 1:b
        idx_ingroup = find(groupmembership == groupidx(j));
        loss_ingroup = loss(idx_ingroup);
        tmp = loss_ingroup;
        [sort_loss, index] = sort(loss_ingroup);
        len = size(sort_loss, 2);
        for ii = 1:size(sort_loss, 2)
            rst= find(loss_ingroup(ii) == tmp); 
            rank_ingroup(ii) = rst(1);
            tmp(rst(1)) = -100000000001.1111;
        end
        nj = size(idx_ingroup, 2);
        for i = 1:nj
        if (loss_ingroup(i) < lambda + gamma/(sqrt(rank_ingroup(i))+sqrt(rank_ingroup(i)-1)))
            selectedidx(idx_ingroup(i))=1;
        else 
            selectedidx(idx_ingroup(i))=0;
        end
        selectedsocres(idx_ingroup(i)) = loss_ingroup(i) - lambda - gamma/(sqrt(rank_ingroup(i))+sqrt(rank_ingroup(i)-1));
        end
    end
        selectedidx = find(selectedidx == 1);
        [sort_result, index_result] = sort(selectedsocres(selectedidx));
        result = selectedidx(index_result);
