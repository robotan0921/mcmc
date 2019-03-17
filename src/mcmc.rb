#
# mcmc.rb
#

# [Q]x,y 
# q = Array.new(81, 0){ Array.new(81, 0) }
# q[0][0] = 0.5
# q[0][1] = 0.5
# q[80][80] = 0.5
# q[80][79] = 0.5
# for x in 1..79 do
#     for y in 0..80 do
#         q[x][y] = 0.5 if (x-y).abs == 1
#     end
# end

N = 1000000  # 試行回数
x = Array.new(N)
pi = Array.new(81, 0)

# Step 0
x[0] = 0

# Step n
for i in 1..N do
    # Step n-A
    if (Random.rand 0.0..1.0) < 0.5 then
        y = x[i-1] + 1
        alpha = [(709-x[i-1])*(80-x[i-1])/y/(629+y).to_f, 1].min
    else
        y = x[i-1] - 1
        alpha = [x[i-1]*(629+x[i-1])/(709-y)/(80-y).to_f, 1].min
    end

    # Step n-B
    if (Random.rand 0.0..1.0) < alpha then
        x[i] = y
    else
        x[i] = x[i-1]
    end

    # for histgram
    pi[x[i]] += 1/N.to_f
end

# 0 ~ 40 までのpiの和
sum = 0.0
for i in 0..40 do
    sum += pi[i]
end

# p pi 
# p pi.inject(:+) # 配列要素の合計(１になるはず)

# 答え
p sum


#
# Rでヒストグラムを描写する用のファイル
#
f = File.open("data.csv","w+")
for i in 0..N
    f.puts "#{x[i]}"
end
f.close
#
#
