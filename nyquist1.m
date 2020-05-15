function [reout,imt,w] = nyquist1(a,b,c,d,iu,w)
%NYQUIST1 Nyquist frequency response for continuous-time linear systems.
%
%       This Version of the  NYQUIST Command takes into account poles at the 
%       jw-axis and loops around them when creating the frequency vector  in order 
%       to produce the appropriate Nyquist Diagram (The NYQUIST command does 
%       not do this and therefore produces an incorrect plot when we have poles in the 
%       jw axis).   
%
%       NOTE: This version of NYQUIST1 does not account for pole-zero 
%       cancellation.  Therefore, the user must simplify the transfer function before using 
%       this command.
%
%       NYQUIST(A,B,C,D,IU) produces a Nyquist plot from the single input
%       IU to all the outputs of the system:             
%               .                                    -1
%               x = Ax + Bu             G(s) = C(sI-A) B + D  
%               y = Cx + Du      RE(w) = real(G(jw)), IM(w) = imag(G(jw))
%
%       The frequency range and number of points are chosen automatically.
%
%       NYQUIST1(NUM,DEN) produces the Nyquist plot for the polynomial 
%       transfer function G(s) = NUM(s)/DEN(s) where NUM and DEN contain
%       the polynomial coefficients in descending powers of s. 
%
%       NYQUIST1(A,B,C,D,IU,W) or NYQUIST(NUM,DEN,W) uses the user-supplied
%       freq. vector W which must contain the frequencies, in radians/sec,
%       at which the Nyquist response is to be evaluated.  When invoked 
%       with left hand arguments,
%               [RE,IM,W] = NYQUIST(A,B,C,D,...)
%               [RE,IM,W] = NYQUIST(NUM,DEN,...) 
%       returns the frequency vector W and matrices RE and IM with as many
%       columns as outputs and length(W) rows.  No plot is drawn on the 
%       screen.
%       See also: LOGSPACE,MARGIN,BODE, and NICHOLS.

%       J.N. Little 10-11-85
%       Revised ACWG 8-15-89, CMT 7-9-90, ACWG 2-12-91, 6-21-92, 
%               AFP 2-23-93
%               WCM 8-31-97
%
%  ********************************************************************
%  Modifications made to the nyquist - takes into account poles on jw axis.
%  then goes around these to make up frequency vector
%  


if nargin==0, eval('exresp(''nyquist'')'), return, end

% --- Determine which syntax is being used ---
nargin1 = nargin;
nargout1 = nargout;
if (nargin1==1),	% System form without frequency vector
		[num,den]=tfdata(a,'v');
		z = roots(num);
		p = roots(den);
		zp = [z;p];
		wpos = zp(find(abs(zp)>0));
		if(min(abs(p)) == 0)
			wstart = max(eps, 0.03*min([1;wpos]));
		else 
			wstart = max(eps, 0.03*min(abs(zp)));
		end
		wstop = max([1000;30*wpos]);
		w = logspace(log10(wstart),log10(wstop),max(51,10*max(size(zp))+1));

		%w = freqint2(num,den,30);
		[ny,nn] = size(num); nu = 1;
        %error('Wrong number of input arguments.');

elseif (nargin1==2),     
		if(isa(a,'ss')|isa(a,'tf')|isa(a,'zpk')) % System with frequency vector
			[num,den]=tfdata(a,'v');
			w = b;
		else	% Transfer function form without frequency vector
        	num  = a; den = b;
			z = roots(num);
			p = roots(den);
			zp = [z;p];
			wpos = zp(find(abs(zp)>0));
			if(min(abs(p)) == 0)
			wstart = max(eps, 0.03*min([1;wpos]));
		else 
			wstart = max(eps, 0.03*min(abs(zp)));
		end
			wstop = max([1000;30*wpos]);
			w = logspace(log10(wstart),log10(wstop),max(51,10*max(size(zp))+1));
        	%w = freqint2(num,den,30);
		end
        [ny,nn] = size(num); nu = 1;

elseif (nargin1==3),     % Transfer function form with frequency vector
        num = a; den = b;
        w = c;
        [ny,nn] = size(num); nu = 1;

elseif (nargin1==4),     % State space system, w/o iu or frequency vector
        error(abcdchk(a,b,c,d));
			[num,den] = ss2tf(a,b,c,d);
			[z,p,k]= ss2zp(a,b,c,d);
			[num,den] = zp2tf(z,p,k);
			zp = [z;p];
			wpos = zp(find(abs(zp)>0));
			if(min(abs(p)) == 0)
			wstart = max(eps, 0.03*min([1;wpos]));
		else 
			wstart = max(eps, 0.03*min(abs(zp)));
		end
			wstop = max([1000;30*wpos]);
			w = logspace(log10(wstart),log10(wstop),max(51,10*max(size(zp))+1));
			%w = freqint2(a,b,c,d,30);
        nargin1 = 2;%[iu,nargin,re,im]=mulresp('nyquist',a,b,c,d,w,nargout1,0);
        %if ~iu, if nargout, reout = re; end, return, end
        [ny,nu] = size(d);

elseif (nargin1==5),     % State space system, with iu but w/o freq. vector
        error(abcdchk(a,b,c,d));
        z = tzero(a,b,c,d);
		p = eig(a);
		zp = [z;p];
		wpos = zp(find(abs(zp)>0));
		if(min(abs(p)) == 0)
			wstart = max(eps, 0.03*min([1;wpos]));
		else 
			wstart = max(eps, 0.03*min(abs(zp)));
		end
		wstop = max([1000;30*wpos]);
		w = logspace(log10(wstart),log10(wstop),max(51,10*max(size(zp))+1));
		%w = freqint2(a,b,c,d,30);
        [ny,nu] = size(d);

else
        error(abcdchk(a,b,c,d));
        [ny,nu] = size(d);

end

if nu*ny==0, im=[]; w=[]; if nargout~=0, reout=[]; end, return, end

% ********************************************************************* 
% depart from the regular nyquist program here
% now we have a frequency vector, a numerator and denominator
% now we create code to go around all poles and zeroes here.

if (nargin1==5) | (nargin1 ==4) | (nargin1 == 6)
        [num,den]=ss2tf(a,b,c,d);
end 
tol = 1e-6;  %defined tolerance for finding imaginary poles
z = roots(num);
p = roots(den);
% ***** If all of the poles are at the origin, just move them a tad to the left*** 
if norm(p) == 0
 if(isempty(z))
  tad = 1e-1;
 else
	tad = min([1e-1; 0.1*abs(z)]);
end


 length_p = length(p);
 p = -tad*ones(length_p,1);
 den = den(1,1)*[1  tad];
 for ii = 2:length_p
  den = conv(den,[1  tad]);
end

	zp = [z;p];
	wpos = zp(find(abs(zp)>0));
	if(min(abs(p)) == 0)
			wstart = max(eps, 0.03*min([1;wpos]));
		else 
			wstart = max(eps, 0.03*min(abs(zp)));
		end
	wstop = max([1000;30*wpos]);
	w = logspace(log10(wstart),log10(wstop),max(51,10*max(size(zp))+1));
 %w = freqint2(num,den,30);
end
 
zp = [z;p];        % combine the zeros and poles of the system
nzp = length(zp);  % number of zeros and poles
ones_zp=ones(nzp,1); 

Ipo = find((abs(real(p))< tol) & (imag(p)>=0)); %index poles with zero real part + non-neg imag part
if  ~isempty(Ipo)   % 
% **** only if we have such poles do we do the following:*************************
po = p(Ipo); % poles with 0 real part and non-negative imag part
% check for distinct poles
[y,ipo] = sort(imag(po));  % sort imaginary parts
po = po(ipo);
dpo = diff(po);
idpo = find(abs(dpo)> tol);
idpo = [1;idpo+1];   % indexes of the distinct poles

po = po(idpo);   % only distinct poles are used 
nIpo = length(idpo); % # of such poles
originflag = find(imag(po)==0);  % locate origin pole

s = [];  % s is our frequency response vector
w = sqrt(-1)*w;  % create a jwo vector to evaluate all frequencies with
for ii=1:nIpo % for all Ipo poles
        
        [nrows,ncolumns]=size(w);
        if nrows == 1
                w = w.';  % if w is a row, make it a column
        end;
        if nIpo == 1
                r(ii) = .1;
        else            % check distances to other poles and zeroes
                pdiff = zp-po(ii)*ones_zp;  % find the differences between
                % poles you are checking and other poles and zeros
                ipdiff = find(abs(pdiff)> tol); % ipdiff is all nonzero differences
                
                r(ii)=0.2*min(abs(pdiff(ipdiff))); % take half this difference
                r(ii)=min(r(ii),0.1);  % take the minimum of this diff.and .1
        end;
        t = linspace(-pi/2,pi/2,25); 
        if (ii == originflag)
                t = linspace(0,pi/2,25);
        end;    % gives us a vector of points around each Ipo  
        s1 = po(ii)+r(ii)*(cos(t)+sqrt(-1)*sin(t));  % detour here
        s1 = s1.';  % make sure it is a column

        % Now here I reconstitute s - complex frequency - and 
        % evaluate again.  

        bottomvalue = po(ii)-sqrt(-1)*r(ii);  % take magnitude of imag part
        if (ii ==  originflag)  % if this is an origin point
                bottomvalue = 0;
        end; 
        topvalue = po(ii)+sqrt(-1)*r(ii); % the top value where detour stops
        nbegin = find(imag(w) < imag(bottomvalue)); %
        nnbegin = length(nbegin); % find all the points less than encirclement
        if (nnbegin == 0)& (ii ~= originflag)    % around jw root
                sbegin = 0;
        else sbegin = w(nbegin);
        end;
        nend = find(imag(w) > imag(topvalue));  % find all points greater than 
        nnend = length(nend);    % encirclement around jw root
        if (nnend == 0) 
                send = 0;        
        else send = w(nend);
        end
        w = [sbegin; s1; send];  % reconstituted half of jw axis
end 
else
        w = sqrt(-1)*w;
end
%end  % this ends the loop for imaginary axis poles
% *************************************************************
% back to the regular nyquist program here
% Compute frequency response
if (nargin1==1)|(nargin1==2)|(nargin1==3)
        gt = freqresp(num,den,w);
else
        gt = freqresp(a,b,c,d,iu,w);
end
% ***********************************************************

%        nw = length(gt);
%        mag = abs(gt);   % scaling factor added
%        ang = angle(gt);
%        mag = log2(mag+1);    % scale by log2(mag) throughout
        
%        for n = 1:nw
%                h(n,1) = mag(n,1)*(cos(ang(n,1))+sqrt(-1)*sin(ang(n,1)));
%        end;  % recalculate G(jw) with scaling factor
        
%        gt = h;
% ***********************************************************
ret=real(gt); 
imt=imag(gt);

% If no left hand arguments then plot graph.
if nargout==0,
   status = ishold;
   plot(ret,imt,'r-',ret,-imt,'g--')  

%  plot(real(w),imag(w))        


   set(gca, 'YLimMode', 'auto')
   limits = axis;
   % Set axis hold on because next plot command may rescale
   set(gca, 'YLimMode', 'auto')
   set(gca, 'XLimMode', 'manual')
   hold on
   % Make arrows
   for k=1:size(gt,2),
        g = gt(:,k);
        re = ret(:,k);
        im = imt(:,k);
        sx = limits(2) - limits(1);
        [sy,sample]=max(abs(2*im));
        arrow=[-1;0;-1] + 0.75*sqrt(-1)*[1;0;-1];
        sample=sample+(sample==1);
        reim=diag(g(sample,:));
        d=diag(g(sample+1,:)-g(sample-1,:)); 
        % Rotate arrow taking into account scaling factors sx and sy
        d = real(d)*sy + sqrt(-1)*imag(d)*sx;
        rot=d./abs(d);          % Use this when arrow is not horizontal
        arrow = ones(3,1)*rot'.*arrow;
        scalex = (max(real(arrow)) - min(real(arrow)))*sx/50;
        scaley = (max(imag(arrow)) - min(imag(arrow)))*sy/50;
        arrow = real(arrow)*scalex + sqrt(-1)*imag(arrow)*scaley;
        xy =ones(3,1)*reim' + arrow;
        xy2=ones(3,1)*reim' - arrow;
        [m,n]=size(g); 
        hold on
        plot(real(xy),-imag(xy),'r-',real(xy2),imag(xy2),'g-')
   end
   xlabel('Real Axis'), ylabel('Imag Axis')

   limits = axis;
   % Make cross at s = -1 + j0, i.e the -1 point
   if limits(2) >= -1.5  & limits(1) <= -0.5 % Only plot if -1 point is not far out.
        line1 = (limits(2)-limits(1))/50;
        line2 = (limits(4)-limits(3))/50;
        plot([-1+line1, -1-line1], [0,0], 'w-', [-1, -1], [line2, -line2], 'w-')
   end

   % Axis
   plot([limits(1:2);0,0]',[0,0;limits(3:4)]','w:');
   plot(-1,0,'+k');
   
   if ~status, hold off, end    % Return hold to previous status
   return % Suppress output
end
%reout = ret; 
%   plot(real(p),imag(p),'x',real(z),imag(z),'o');
