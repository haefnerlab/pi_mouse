function Plot_PI_Learning(fct,varargin)

switch fct
  case 'stim'
    c=varargin{1}; nc=length(c);
    Get_Figure(['PPIL:' fct]);
    Subplot(nc,0);
    for i=1:nc, Subplot;
      plot(c(i).orientations,c(i).rates,'b*');
      plot(0:360,c(i).dirFit,'r-');
      plot(0:360,[c(i).oriFit(1:end-1) c(i).oriFit],'g-');
      Plot_Misc('h',c(i).bkgrate,'b');
    end
    
  case 'behavior'
    c=varargin{1}; nc=length(c);
    Get_Figure(['PPIL:' fct]);
    Subplot(nc,0);
    eps=1e-4;
    for i=1:nc, Subplot;
      con=Unique(c(i).task_contrast,eps);
      for j=1:length(con)
        idx=find(abs(c(i).task_contrast-con(j))<eps);
        st={c(i).task_stimSpikes{idx}};
        hit ={st{find( c(i).task_rewardedTrial(idx))}};
        miss={st{find(~c(i).task_rewardedTrial(idx))}};
        ntrials_hit {i}(j)=length(hit );
        ntrials_miss{i}(j)=length(miss);
        if ntrials_hit{i}(j)<1, rate_hit{i}(j)=-1;
        else
          count=0;
          for k=1:ntrials_hit{i}(j), count=count+length(hit{k}); end
          rate_hit{i}(j)=count/ntrials_hit{i}(j);
        end
        if ntrials_miss{i}(j)<1, rate_miss{i}(j)=-1;
        else
          count=0;
          for k=1:ntrials_miss{i}(j), count=count+length(miss{k}); end
          rate_miss{i}(j)=count/ntrials_miss{i}(j);
        end
      end
      %plot(con,rate_hit{i},'b-');
      %plot(con,rate_miss{i},'r-');
      plot(con,rate_hit{i}-rate_miss{i},'b.-');
      diff_err{i}=sqrt(rate_hit{i}/ntrials_hit{i}+rate_miss{i}/ntrials_miss{i});
      plot(con,rate_hit{i}-rate_miss{i}-diff_err{i},'b--');
      plot(con,rate_hit{i}-rate_miss{i}+diff_err{i},'b--');
      set(gca,'xscale','log');
      Plot_Misc('h',0);
    end    
  otherwise
    error(fct);
end
    
end

