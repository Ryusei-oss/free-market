men = Category.create(name: "メンズ")

men_1 = men.children.create(name: "トップス")

men_1.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"},{name: "Tシャツ/カットソー(七分/長袖)"},{name: "シャツ"},{name: "ポロシャツ"},{name: "タンクトップ"},{name: "ニット/セーター"},{name: "パーカー"},{name: "カーディガン"},{name: "スウェット"},{name: "ジャージ"},{name: "ベスト"},{name: "その他"}])
