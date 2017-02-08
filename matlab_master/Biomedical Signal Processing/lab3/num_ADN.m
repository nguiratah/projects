function agct = num_ADN(s);

% agct = num_ADN(s);
% transforms a character string of nucleotides into numerical sequences
% s file name (don't forget the ' ')
% agct matrix - 1st column for A, 2nd for G ....

fid = fopen(s);
chaie = fgets(fid);

N = length(chaie);
agct = zeros(N,4);
x1 = zeros(N,1);
x2 = x1;

compt1 = 0;
compt2 = 0;

for k=1:N,
   switch chaie(k)
      case 'A'
         agct(k,1) = 1;
         compt1 = compt1 + 1;
         compt2 = compt2 + 1;
      case 'G'
         agct(k,2) = 1; 
         compt1 = compt1 - 1;
         compt2 = compt2 - 1;
      case 'C'
         agct(k,3) = 1; 
         compt1 = compt1 - 1;
         compt2 = compt2 + 1;
      case 'T'
         agct(k,4) = 1;
         compt1 = compt1 + 1;
         compt2 = compt2 - 1;
      end
      x1(k) = compt1;
      x2(k) = compt2;
end

fclose(fid);

         
    
