//go:build !arm64

package adler32

import (
	"hash"
	"hash/adler32"
)

// The size of an Adler-32 checksum in bytes.
const Size = 4

// New returns a new hash.Hash32 computing the Adler-32 checksum.
func New() hash.Hash {
	return adler32.New()
}

// Checksum returns the Adler-32 checksum of data.
func Checksum(data []byte) uint32 { return adler32.Checksum(data) }
