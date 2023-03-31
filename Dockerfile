FROM golang:1.18-alpine as builder
RUN apk add --no-cache gcc musl-dev linux-headers git make bash curl 
RUN git clone https://github.com/Altcoinchain/go-altcoinchain.git
RUN cd go-altcoinchain/cmd/geth && go mod tidy && go build . 
RUN chmod +x ./go-altcoinchain/cmd/geth
RUN mv ./go-altcoinchain/cmd/geth/geth /usr/local/bin
RUN geth  init --datadir ./altcoinchain altcoinchain/genesis.json
ENTRYPOINT ["geth", "--datadir=./altcoinchain", "--networkid=2330", "--nodiscover", "--bootnodes=enode://448f7d24183a57d4dd6c8769e55621ecc8362215f6c2d22c363953f392fb572cbbb382a6324997445b2340f44a1bd2b7b76d80b2e0efb05a2627aa9f62aa4440@154.12.237.243:30305,enode://3a1f8dc38b7def6336765e37acb52b7520ae710448ca8814fce82ef89a6a3f4fe60c497bae5982168381388cd8d131155d77585ce1577727fbfc62beb261993d@144.76.202.175:30303"]