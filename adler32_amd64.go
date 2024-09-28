package adler32

import (
	"hash"
	"hash/adler32"

	"golang.org/x/sys/cpu"
)

// The size of an Adler-32 checksum in bytes.
const Size = 4

var hasSSE3 = cpu.X86.HasSSE3

// digest represents the partial evaluation of a checksum.
// The low 16 bits are s1, the high 16 bits are s2.
type digest uint32

func (d *digest) Reset() { *d = 1 }

// New returns a new hash.Hash32 computing the Adler-32 checksum.
func New() hash.Hash32 {
	if !hasSSE3 {
		return adler32.New()
	}
	d := new(digest)
	d.Reset()
	return d
}

func (d *digest) Size() int { return Size }

func (d *digest) BlockSize() int { return 4 }

func (d *digest) Write(p []byte) (nn int, err error) {
	if len(p) >= 64 {
		h := adler32_simd(uint32(*d), p)
		*d = digest(h)
	} else {
		h := update(uint32(*d), p)
		*d = digest(h)
	}
	return len(p), nil
}

func (d *digest) Sum32() uint32 { return uint32(*d) }

func (d *digest) Sum(in []byte) []byte {
	s := uint32(*d)
	return append(in, byte(s>>24), byte(s>>16), byte(s>>8), byte(s))
}

// Checksum returns the Adler-32 checksum of data.
func Checksum(data []byte) uint32 {
	if !hasSSE3 || len(data) < 64 {
		return update(1, data)
	}

	return adler32_simd(1, data)
}
