export type Player = {
    name: string, club: string, nationality: string, rank: number, noOfVotes: number
}

export const dummyPlayers: Player[] = [
    {
        name: "Erling Haaland",
        club: "Manchester City FC",
        nationality: "Norway",
        rank: 1,
        noOfVotes: 2804
    }, 
    {
        name: "Kylian Mbappe",
        club: "Real Madrid CF",
        nationality: "France",
        rank: 2,
        noOfVotes: 2790
    }, 
    {
        name: "Mohammed Salah",
        club: "Liverpool FC",
        nationality: "Egypt",
        rank: 3,
        noOfVotes: 2789
    },
    {
        name: "Raphinha",
        club: "FC Barcelona",
        nationality: "Brazil",
        rank: 4,
        noOfVotes: 2750,
    },
    {
        name: "Lamine Yamal",
        club: "FC Barcelona",
        nationality: "Spain",
        rank: 5,
        noOfVotes: 2725
    },
    {
        name: "Victor Gyokeres",
        club: "Sporting Lisbon",
        nationality: "Sweden",
        rank: 6,
        noOfVotes: 2662
    }
]

export const dummyNominees: Partial<Player>[] = [
    {
        name: "Bukayo Saka",
        club: "Arsenal",
        nationality: "England"
    },
    {
        name: "Cole Palmer",
        club: "Chelsea",
        nationality: "England"
    },
    {
        name: "Wilfrid Okorie",
        club: "The GOATs",
        nationality: "Heaven"
    },
]