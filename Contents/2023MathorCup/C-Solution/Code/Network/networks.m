load Series.mat

n=length(Gragh);
ind_start=1;
while(ind_start<=n)
    ind_end=During(ind_start,Date,n);
    Matrix=makeAdj(Gragh(ind_start:ind_end,:),num);
    [starts,endsWith]=;
    Painting(Gragh);
    ind_start=ind_end+1;
end
clear ind_start ind_end

function Matrix=makeAdj(edges,num)
    Matrix=zeros(num);
    num_connect=0;
    n=length(edges);
    for i=1:n
        Matrix(edges(i,1),edges(i,2))=Matrix(edges(i,1),edges(i,2))+1;
        if (Matrix(edges(i,1),edges(i,2))==1)
            num_connect=num_connect+1;
        end
    end
end
function [starts,ends]=checkterm(subGragh)
    
    num_start=0;
    for i=1:num
        if (any(Matrix(:,i))==0)%i点没有出度
            num_start=num_start+1;
            ind_start(1,num_start)=i;
        end
    end
    clear i
    num_end=0;
    for i=1:num
        if (any(Matrix(i,:))==0)%i点没有入度
            num_end=num_end+1;
            ind_end(1,num_end)=i;
        end
    end
end
function Painting()
    
end
function ind=During(init,Date,n)
    val=Date(init);
    for i=init:n
        if (Date(i)~=val)
            break
        end
    end
    if (i==n)
        ind=n;
    else
        ind=i-1;
    end
end
function str=Node(node)
    str=strcat("DC",num2str(node));
end