import { MerkleTree } from "merkletreejs";
import keccak256 from "keccak256";
import fs from "fs";
import csvParser from "csv-parser";

async function generateMerkleProof(targetAddress: string): Promise<void> {
  const addresses: string[] = [];

  await new Promise<void>((resolve, reject) => {
    fs.createReadStream("./merkle/airdrop.csv")
      .pipe(csvParser())
      .on("data", (row: { address: string }) => {
        addresses.push(row.address.toLowerCase());
      })
      .on("end", resolve)
      .on("error", reject);
  });

  // Add test addresses if they're not already in the list
  const testAddresses = [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"
  ];
  testAddresses.forEach((addr) => {
    if (!addresses.includes(addr.toLowerCase())) {
      addresses.push(addr.toLowerCase());
    }
  });

  const leaves = addresses.map((addr) => keccak256(addr));
  const tree = new MerkleTree(leaves, keccak256, { sortPairs: true });
  const leaf = keccak256(targetAddress.toLowerCase());
  const proof = tree.getHexProof(leaf);

  console.log(JSON.stringify(proof));
}

const targetAddress = process.argv[2];
if (!targetAddress) {
  console.error("Please provide a target address as an argument");
  process.exit(1);
}

generateMerkleProof(targetAddress).catch(console.error);
