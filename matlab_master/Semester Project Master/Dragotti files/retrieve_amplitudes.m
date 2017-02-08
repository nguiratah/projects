function ap = retrieve_amplitudes(x, t, sp, delta_t, center)

% Temporal resolution
T_s = t(2) - t(1);

if nargin < 5
    center = 0.5;
    if nargin < 4
        delta_t = 7 * T_s;
    end
end

dt_before = delta_t * center;
dt_after  = delta_t * (1 - center);

num_spikes = length(sp);
ap         = zeros(size(sp));

for ith_sp = 1 : num_spikes
    sp_cur = sp(ith_sp);
    idx    = find(t >= sp_cur - dt_before & t <= sp_cur + dt_after);
    [ap_cur, locs] = findpeaks(x(idx));
    
    if length(ap_cur) > 1
%         [min_dt, idx_min] = min(abs(t(locs + idx(1) - 1) - sp_cur));
%         
%         if t(locs(idx_min) + idx(1) - 1) > sp_cur
%             id = find( t(idx) == sp_cur + min_dt ) + idx(1) - 1;
%         else
%             id = find( t(idx) == sp_cur - min_dt ) + idx(1) - 1;
%         end
%         
%         ap(ith_sp) = x(id);

        ap(ith_sp) = max(ap_cur);
        
%     elseif isempty(ap_cur)
%         warning(['No peaks found for the ' num2str(ith_sp) '-th spike'])
    elseif ~isempty(ap_cur)
        ap(ith_sp) = ap_cur;
    end
end