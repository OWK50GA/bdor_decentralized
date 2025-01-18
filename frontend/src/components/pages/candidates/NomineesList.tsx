import { dummyNominees } from "@/lib/data";

const NomineesList = () => {

    const nominees = dummyNominees

    return ( 
        <div>
            <h2>Nominees List</h2>
            <table>
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    {
                        nominees.map((n, i) => {
                            return (
                                <tr key={i}>
                                    <td className="px-3 py-3">{n.name}</td>
                                    <td className="px-3 py-3">{3}</td>
                                    <td className="px-3 py-3">
                                        <input type="checkbox" name="" id="" />
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
 
export default NomineesList;