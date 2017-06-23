function [score1,score2,cube] = rockpaper(M)
% 
% function [score1,score2,cube] = rockpaper(M)
%
% M is the order, valid choices are M=1..5
%
% score1 = computer's score
% score2 = your score
% cube   = unnormalized counts from the past game rounds
%
%

plays = ['R' 'P' 'S'];

if (M==1)
  cube = ones(3,1);
elseif (M==2)
  cube = ones(3,3);
elseif (M==3)
  cube = ones(3,3,3);
elseif (M==4)
  cube = ones(3,3,3,3);
elseif (M==5)
  cube = ones(3,3,3,3,3);
end

inside  = 1;
mm = ones(M,1);
myplay = 1;
yourplay = 1;

score1 = 0;
score2 = 0;

while (inside>0)
  clf
  axis([0 1 0 1])
  axis('off')
  t=0:0.5:1.0;
  plot(t,0.8*ones(1,length(t)));
  hold on
  plot(t,0*ones(1,length(t)),'k');
  plot(t,ones(1,length(t)),'k');
  plot(0*ones(1,length(t)),t,'k');
  plot(ones(1,length(t)),t,'k');
  text(0.2,0.3,'Use Left-Middle-Right Mouse Buttons');
  text(0.2,0.9,'Rock-Paper-Scissors (Click Here to Quit)');
  strang = sprintf('Last Play: Me=%s You=%s',plays(myplay),plays(yourplay));
  text(0.2,0.7,strang);
  strang = sprintf('Computer Wins %d, Your Wins %d\n',score1,score2);
  text(0.2,0.1,strang);
  axis([0 1 0 1])
  axis('off')
  myplay = 1;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% INSERT CODE TO FIGURE OUT THE BEST PLAY HERE
  %%% SET THE VARIABLE myplay = 1,2 or 3
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  strang = sprintf('Click Here to Play, My Guess is %s',plays(myplay));
  text(0.2,0.5,strang);
  [x,y,click] = ginput(1);
  mm = [mm(2:M); click(1)];
  yourplay = click(1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% INSERT CODE TO UPDATE THE PROBABILITY CUBE HERE
  %%% cube = ???
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if (yourplay==myplay)
     score1=score1;
  elseif ((myplay==1) & (yourplay==2))
     score2=score2+1;
  elseif ((myplay==2) & (yourplay==3))
     score2=score2+1;
  elseif ((myplay==3) & (yourplay==1))
     score2=score2+1;
  elseif ((myplay==2) & (yourplay==1))
     score1=score1+1;
  elseif ((myplay==3) & (yourplay==2))
     score1=score1+1;
  elseif ((myplay==1) & (yourplay==3))
     score1=score1+1;
  end
  
  if (y>0.8)
     inside = -1;
  end
  end66666666666667