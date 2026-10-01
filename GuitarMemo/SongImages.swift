//
//  SongImages.swift
//  GuitarMemo
//

/// Cover art for the bundled songs, keyed by song title (file name without extension).
/// Album artwork from the Apple Music catalog. "Mimoza - Dama" and "Maratra hambom-po - Mage 4"
/// are not in the catalog, so they use an album by the same artist (Mahaleo, Mage 4).
enum SongImages {
    static let byTitle: [String: String] = [
        "All of me - John Legend": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/22/71/b9/2271b906-85b3-06ee-e611-489b91df0b73/886444160742.jpg/600x600bb.jpg",
        "Ave Maria - Beyonce": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/35/0f/55/350f55da-2104-162a-5872-cb35fef30410/mzi.morbeoaw.jpg/600x600bb.jpg",
        "Count on me - Bruno Mars": "https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/52/b1/45/52b1452b-229e-78db-231b-7b43fa0077cc/075679956491.jpg/600x600bb.jpg",
        "Hallelujah": "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/26/d6/e3/26d6e339-a7a9-d61e-1b5f-0852a5515a55/886445517880.jpg/600x600bb.jpg",
        "Hélène - Roch Voisine": "https://is1-ssl.mzstatic.com/image/thumb/Features/35/84/72/dj.gyrivklc.jpg/600x600bb.jpg",
        "I don't wanna miss a thing - Aerosmith": "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/0a/f1/af/0af1af45-7deb-3252-15e2-c1394b574d64/mzi.lfxshysm.jpg/600x600bb.jpg",
        "Je te promets - Zaho": "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/46/7b/c3/467bc35c-db8c-e81c-cce6-f1d19df1f601/cover.jpg/600x600bb.jpg",
        "Maratra hambom-po - Mage 4": "https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/bf/77/27/bf7727f6-44c4-ff4b-d210-607a278c8fd1/8433391593110.jpg/600x600bb.jpg",
        "Mimoza - Dama": "https://is1-ssl.mzstatic.com/image/thumb/Music/45/4b/70/mzi.zglhfqul.jpg/600x600bb.jpg",
        "Mon Essentiel - Emmanuel Moire": "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m08/d03/h11/mzi.ukdjbzbe.jpg/600x600bb.jpg",
        "Nothing else matters - Metallica": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/9e/80/1b/9e801b06-67fa-0990-2d15-85480ad3cd46/850007452025.png/600x600bb.jpg",
        "Numb - Linkin Park": "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/13/44/05/134405bd-9e27-a678-8953-b5f724201f95/093624948988.jpg/600x600bb.jpg",
        "Set fire to the rain - Adele": "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/eb/ca/25/ebca2596-cd1e-b295-91a3-771c868d0a79/191404113868.png/600x600bb.jpg",
        "Someone like you - Adele": "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/eb/ca/25/ebca2596-cd1e-b295-91a3-771c868d0a79/191404113868.png/600x600bb.jpg",
        "Somewhere Over the Rainbow - Israel Kamakawiwo'ole": "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/90/78/a0/9078a0b2-04ff-6bae-8adc-23d099f67031/s05.bhjhywpg.jpg/600x600bb.jpg",
        "We are the world": "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m01/d20/h14/s05.bkornbke.jpg/600x600bb.jpg",
        "When you say nothing at all - Ronan Keating": "https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/33/7c/66/337c6647-f101-ff34-b589-9624ce856fb4/00602498684559.rgb.jpg/600x600bb.jpg",
        "Wild world - Cat Stevens": "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/fc/e6/a9/fce6a952-aa1b-4c75-50d5-da7716d1bd5c/20UMGIM86272.rgb.jpg/600x600bb.jpg",
        "Wonderful life - Black": "https://is1-ssl.mzstatic.com/image/thumb/Music/0d/dc/66/mzi.noidarmz.tif/600x600bb.jpg",
        "Wonderful tonight - Eric Clapton": "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/e6/8b/8e/e68b8eb1-ddce-3332-4e66-5a15ccc04d6f/00600753407301.rgb.jpg/600x600bb.jpg",
        "Ya Jbal Rif - Saida Fikri": "https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/68/b8/d0/68b8d082-add1-afb8-4cce-8063b1bc69dc/artwork.jpg/600x600bb.jpg",
        "You're still the one - Shania Twain": "https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/1e/2f/98/1e2f98c2-3fa6-9601-9825-6a6d19a99cf3/06UMGIM07033.rgb.jpg/600x600bb.jpg",
        "Zina - Babylone": "https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/8e/ab/bd/8eabbd50-956d-01d7-fe57-552d9b2bb7d3/3610153162240_cover.jpg/600x600bb.jpg",
        "Zombie - Cranberries": "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/a3/77/a3/a377a309-8e52-f787-2250-2b34d320bf7b/25UMGIM64146.rgb.jpg/600x600bb.jpg",
    ]
}
