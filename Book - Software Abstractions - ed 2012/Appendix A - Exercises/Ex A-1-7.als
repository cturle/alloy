module exercises/ring

sig Node {next: set Node}

pred isRing [] {
	(Node <: next) in Node one -> one Node
  all n: Node | n.*(Node <: next) = Node
}

run isRing for exactly 4 Node
