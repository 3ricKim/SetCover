function result=setcover(covby)

    %finding all the elements in the universe
    universe=unique(covby);
    universe(universe==0)=[];
    %universe=universe';
    result=zeros(1,length(covby));

    %finding each set size
    count=zeros(1,length(covby));
    for i=1:length(covby)
        a=covby(i,:);
        a(a==0)=[];
        count(i)=length(a);
    end

    %finding the row with maximum size set
    [~,place]=sort(count,'descend');

    for i=1:length(covby)
        a=covby(place(i),:);
        a(a==0)=[];
        for j=1:length(a)
            for k=1:length(universe)
                if(a(j)==universe(k))
                    universe(k)=0;
                    result(place(i))=1;
                    break;
                end
            end
        end    
        if(sum(universe)==0)
            break
        end
    end
end