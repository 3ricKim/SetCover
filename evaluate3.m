function [fitness,sol] = evaluate3(pos,lenofsol,mm,universe)
    NoE=lenofsol; % total no. of elemnets in sequence
    per=pos; %per  is for percentage
    NoO=round(NoE*per/100); % no. of ones calculated from precentage
    sig=[ones(1,NoO),zeros(1,NoE-NoO)]; % creating a sequence having ones and zeros like [1 1 1 ...0 0 0 ]
                                        %we need to permutate position of
                                        %above 1s/0s
    
    for i1=1:1 % This loop is optional to try more number of permutations and keep the best
                % for the timing only one iteration means one permutation
    sol=sig(randperm(length(sig))); %  sol is permutated 1s/0s
    result=zeros(1,length(mm));
    for i=1:length(mm)
        a=0;
        universe1=universe;
        if sol(i)==1
        a=[a,mm(i,:)];
        a(a==0)=[];
        end
        for j=1:length(a)
            for k=1:length(universe1)
                if(a(j)==universe1(k))
                    universe1(k)=0;
                    result(i)=1;
                    break;
                end
            end
        end    
        if(sum(universe1)==0)
            break
        end
    end
    fitness1(i1)=sum(result);
    end
    fitness=min(fitness1);% If first for loop checks multiple premuations then keep the minimum 1
                           % Not recomended
end
