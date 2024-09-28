package adler32

import (
	"hash/adler32"
	"math/rand"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAdler32(t *testing.T) {
	for i := 0; i < 1024; i++ {
		// generated random data
		data := genRandomData(i)
		want := adler32.Checksum(data)
		got := Checksum(data)

		assert.Equal(t, want, got)
	}
}

func TestAdler32Partial(t *testing.T) {
	h := New()

	for i := 32; i < 1024; i++ {
		// generated random data
		data := genRandomData(i)

		want := adler32.Checksum(data)

		h.Reset()
		// split into a few parts
		for j := 0; j < len(data); j += 64 {
			end := j + 64
			if end > len(data) {
				end = len(data)
			}
			h.Write(data[j:end])
		}
		got := h.Sum32()

		assert.Equal(t, want, got)
	}
}

func genRandomData(sz int) []byte {
	buf := make([]byte, sz)
	_, err := rand.Read(buf)
	if err != nil {
		panic(err)
	}
	return buf
}

func BenchmarkAdler32KB(b *testing.B) {
	const sz = 32
	data := make([]byte, sz)
	for i := range data {
		data[i] = byte(i)
	}

	b.Run("stdlib", func(b *testing.B) {
		h := adler32.New()
		in := make([]byte, 0, h.Size())

		for i := 0; i < b.N; i++ {
			h.Reset()
			h.Write(data)
			h.Sum(in)
		}

		b.SetBytes(sz)
	})

	b.Run("simd", func(b *testing.B) {
		h := New()
		in := make([]byte, 0, h.Size())

		for i := 0; i < b.N; i++ {
			h.Reset()
			h.Write(data)
			h.Sum(in)
		}

		b.SetBytes(sz)
	})
}
