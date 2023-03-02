function Matric_after_del = generate_matric_del(matric_src, num_del, del_way)
[row,col] = size(matric_src);
if strcmp(del_way,'min')
    dig_matric = diag(matric_src)';%N*1
    [dig_matric_sorted, idx] = sort(dig_matric);
    idx = idx(1:num_del);
    matric_src(idx,:) = [];
    matric_src(:, idx) = [];
    Matric_after_del = matric_src;
elseif strcmp(del_way,'max')
    dig_matric = diag(matric_src)';%N*1
    [dig_matric_sorted, idx] = sort(dig_matric,'ascend');
    idx = idx(1:num_del);
    matric_src(idx,:) = [];
    matric_src(:, idx) = [];
    Matric_after_del = matric_src;
elseif strcmp(del_way,'random')
    idx = randperm(row);
    idx = idx(1:num_del);
    matric_src(idx,:) = [];
    matric_src(:, idx) = [];
    Matric_after_del = matric_src;
end
    
end