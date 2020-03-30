function aggregate_tokens_files(filelist,outfile)

% verify all files exist and are same size
F=[]; F.file = load_lines(filelist);
fprintf('Verifying all files... ');
demand_files(F.file);
F.filesize = get_filesize(F.file);
len = unique(F.filesize);
if length(len)>1
  count(F.filesize);
  error('Filesizes are not uniform');
end

% open all files for reading
fprintf('Opening all files... ');
nf = slength(F);
F.in = cell(nf,1);
for f=1:nf, if ~mod(f,100), fprintf('%d/%d ',f,nf); end
  F.in{f} = fopen(F.file{f},'rb');
end
fprintf('\n');

% open output file for writing
out = fopen(outfile,'wb');

% do the aggregation
stepsize = 1e5;
F.chunk = zeros(nf,stepsize);
h = zeros(8,stepsize);
for st=1:stepsize:len
  en = min(st+stepsize-1,len);
  fprintf('[%s] Processing positions %d-%d...',datestr(now),st,en);

  chunksize = en-st+1;
  if chunksize<stepsize
    F.chunk = zeros(nf,chunksize);
    h = zeros(8,chunksize);
  end

  fprintf('  [reading]');
  for f=1:nf, if ~mod(f,100), fprintf(' %d/%d',f,nf); end
    F.chunk(f,:) = fread(F.in{f},chunksize,'uint8');
  end

  fprintf('  [aggregating]');
  tokens = double('-+123456');
  for j=1:8
    h(j,:) = sum(F.chunk==tokens(j),1);
  end

  fprintf('  [writing]');
  fwrite(out,h(:),'uint16');

  fprintf('\n');
end

fprintf('Done.\n');

% close all files
fclose(out);
for f=1:nf, fclose(F.in{f}); end



