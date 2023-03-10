function num_link = num_inner_link(matric, delete)
matric_delete = matric(delete, delete);
matric_delete = triu(matric_delete,1);
num_link = -sum(sum(matric_delete));
end