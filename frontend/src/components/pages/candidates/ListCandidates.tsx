import { dummyPlayers } from "@/lib/data";

const ListCandidates = () => {
    const candidates = dummyPlayers
    return ( 
        <div>
            <table>
                <thead>
                    <tr>
                        <th className="px-3 py-3">Candidate Name</th>
                        <th className="px-3 py-3">Country</th>
                        <th className="px-3 py-3">Club</th>
                        <th className="px-3 py-3">{" "}</th>
                    </tr>
                </thead>

                <tbody>
                    {
                        candidates.map((candidate, index) => {
                            return (
                                <tr key={index} className="hover:text-gold-500">
                                    <td className="px-3 py-3">{candidate.name}</td>
                                    <td className="px-3 py-3">{candidate.nationality}</td>
                                    <td className="px-3 py-3">{candidate.club}</td>
                                    <td className="px-3 py-3">
                                        <button className="bg-gold-500 px-2 py-2 rounded-lg text-black">Vote</button>
                                    </td>
                                </tr>         
                            )
                        })
                    }
                </tbody>
            </table>
        </div>
    );
}
 
export default ListCandidates;