function SimilarityMatrix = communitySimilarity(A_mat,B_mat)
%%
%
%
%
%
%
%
%%

a = unique(A_mat);
allCommA = a(a~=0);
b = unique(B_mat);
allCommB = b(b~=0);

SimilarityAB = zeros(1,length(allCommB));
SimilarityMatrix = zeros(length(allCommA),length(allCommB));

for A = 1:length(allCommA)
    communityA = allCommA(A);
    
    for B = 1:length(allCommB)
         communityB = allCommB(B);
         jaccard = zeros(1,length(A_mat) - 1);
         
       for subDiagonal = 1:length(A_mat) - 1
          a = find(diag(A_mat,subDiagonal) == communityA);
          b = find(diag(B_mat,subDiagonal) == communityB);
          jaccard(subDiagonal) = length(intersect(a,b))/length(union(a,b)); 
       end
         
         JacIndex = nanmean(jaccard,'all'); 
         SimilarityAB(B) = JacIndex;
     end
         
         SimilarityMatrix(A,:) = SimilarityAB;
         SimilarityMatrix(isnan(SimilarityMatrix)) = 0;
end
