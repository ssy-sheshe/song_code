function  value = algorithm_reproduct(matric_src, L)

Matri_A= matric_src;
[row, ~]= size(Matri_A);
%���ݽڵ�ȵĴ�С���У�����ɸѡ
Matri_diag = diag(Matri_A);
[val_A, idx_A] = sort(Matri_diag,'descend');
max_val = val_A(1:L);
max_dim = idx_A(1:L);
Matri_A1 = Matri_A;
Matri_A1(max_dim,:) = [];
Matri_A1(:,max_dim) = [];
lambda1 = eigs(Matri_A1,1,'sa');
%ɾ��������С����ֵ
%����ѭ�������
eig_end =0;
delete_val = max_val;
delete_idx = max_dim;
while lambda1 >eig_end
      eig_end = lambda1;
      num_link = num_inner_link(Matri_A, delete_idx);
      k = (row - L)*lambda1 - sum(delete_val(1:(L-1))) + 2 * num_link;%�õ���һ��ɸѡֵ����Ӧ��ʽ��6��
      [idx_1, ~, value_1] = find(Matri_diag>=k);
      if isempty(value_1)
          fprintf('ɾ��%d���ڵ��Ӧ����С����ֵ�����ֵ��%6.5f\n',L,lambda1)
          fprintf('ɾ��%d���ڵ��Ӧ���ܿؽڵ�%s\n',L,num2str(delete_idx))
          break
      end
      comb = nchoosek(idx_1,L);%������ڶȵ���Щ�ڵ�
      [comb_row, comb_col] = size(comb);
      comb_new = [];
      for j = 1:comb_row
          comb_value = Matri_diag(comb(j,:),1);
          if (sum(comb_value) - 2 * num_link)/(row-L)>eig_end%��Ӧ��ʽ��11��
              comb_new = [comb_new,comb(j,:)];
          end
      end
      [~, col_row] = size(comb_new);
        for i=1:col_row/L
            A_in = Matri_A;
            dim = comb_new((i-1)*L+1:i*L);
            A_in(dim(1:L),:) = [];
            A_in(:,dim(1:L)) = [];
            min_eig_in = eigs(A_in,1,'sa');
            if lambda1 < min_eig_in
                lambda1 = min_eig_in;
                delete_idx = comb_new((i-1)*L+1:i*L);
                delete_val = sort(Matri_diag(delete_idx,1),'descend');
            end
            %count=count+1;
        end
end

fprintf('ɾ��%d���ڵ��Ӧ����С����ֵ�����ֵ��%6.5f\n',L,lambda1)
fprintf('ɾ��%d���ڵ��Ӧ���ܿؽڵ�%s\n',L,num2str(delete_idx))
value = lambda1;

end

